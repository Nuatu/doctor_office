class Doctor
  attr_accessor :name, :specialty_id, :insurance_id, :id

  def initialize(name,specialty_id,insurance_id, id=nil)
    @name = name
    @specialty_id = specialty_id
    @insurance_id  = insurance_id
    @id = id
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def self.all
    doctors = []
    results = DB.exec("SELECT * FROM doctor;")
    results.each do |result|
      doctors << Doctor.new(result['name'], result['specialty_id'], result['insurance_id'], result['id'])
    end
    doctors
  end

  def save
    @id = DB.exec("INSERT INTO doctor(name, specialty_id, insurance_id) VALUES ('#{@name}', '#{@specialty_id}', '#{@insurance_id}') RETURNING id;").first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM doctor where name = '#{@name}';")
  end

  def update_name(new_name)
    DB.exec("UPDATE doctor SET name = '#{new_name}' WHERE name = '#{@name}';")
    @name = new_name
  end

  def update_specialty_id(new_specialty_id)
    DB.exec("UPDATE doctor SET specialty_id = #{new_specialty_id} WHERE specialty_id = '#{@specialty_id}';")
    @specialty_id = new_specialty_id
  end

  def update_insurance_id(new_insurance_id)
    DB.exec("UPDATE doctor SET insurance_id = '#{new_insurance_id}' WHERE name = '#{@insurance_id}';")
    @insurance_id = new_insurance_id
  end

end


