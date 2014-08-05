class Doctor
  attr_accessor :name, :specialty, :insurance

  def initialize(name,specialty_id,insurance_id)
    @name = name
    @specialty = specialty_id
    @insurance  = insurance_id
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def self.all
    doctors = []
    results = DB.exec("SELECT * FROM doctor;")
    results.each do |result|
      doctors << Doctor.new(result['name'], result['specialty'], result['insurance'])
    end
    doctors
  end

  def save
    DB.exec("INSERT INTO doctor(name, specialty, insurance) VALUES ('#{@name}', '#{@specialty}', '#{@insurance}');")
  end

  def delete
    DB.exec("DELETE FROM doctor where name = '#{@name}';")
  end

  def update_name(new_name)
    DB.exec("UPDATE doctor SET name = '#{new_name}' WHERE name = '#{@name}';")
    @name = new_name
  end

  def update_specialty(new_specialty)
    DB.exec("UPDATE doctor SET specialty = '#{new_specialty}' WHERE specialty = '#{@specialty}';")
    @specialty = new_specialty
  end

  def update_insurance(new_insurance)
    DB.exec("UPDATE doctor SET insurance = '#{new_insurance}' WHERE name = '#{@insurance}';")
    @insurance = new_insurance
  end

end


