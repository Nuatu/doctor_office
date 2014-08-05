class Specialty

  attr_accessor :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def ==(another_specialty)
    self.name == another_specialty.name
  end

  def save
    @id = DB.exec("INSERT INTO specialty(name) VALUES ('#{@name}') RETURNING id;").first[id].to_i
  end

  def delete
    DB.exec("DELETE FROM specialty where name = '#{@name}';")
  end

  def self.all
    specialty = []
    results = DB.exec("SELECT * FROM specialty;")
    results.each do |result|
      specialty << Specialty.new(result['name'],result['id'])
    end
    specialty
  end

  def update_name(new_name)
    DB.exec("UPDATE specialty SET name = '#{new_name}' WHERE name = '#{@name}';")
    @name = new_name
  end

end
