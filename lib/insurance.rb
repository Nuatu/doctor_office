class Insurance

  attr_accessor :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def ==(another_insurance)
    self.name == another_insurance.name
  end

  def save
    @id = DB.exec("INSERT INTO insurance(name) VALUES ('#{@name}') RETURNING id;").first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM insurance where name = '#{@name}';")
  end

  def self.all
    insurance = []
    results = DB.exec("SELECT * FROM insurance;")
    results.each do |result|
      insurance << Insurance.new(result['name'],result['id'])
    end
    insurance
  end

  def update_name(new_name)
    DB.exec("UPDATE insurance SET name = '#{new_name}' WHERE name = '#{@name}';")
    @name = new_name
  end

end
