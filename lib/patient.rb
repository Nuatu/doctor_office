class Patient
  attr_accessor :name, :birthdate, :doctor_id, :id

  def initialize(name,birthdate,doctor_id, id=nil)
    @name = name
    @birthdate = birthdate
    @doctor_id = doctor_id
    @id = id
  end

  def ==(another_patient)
    self.name == another_patient.name
  end

  def self.all
    patients = []
    results = DB.exec("SELECT * FROM patient;")
    results.each do |result|
      patients << Patient.new(result['name'], result['birthdate'], result['doctor_id'])
    end
    patients
  end

  def save
    @id = DB.exec("INSERT INTO patient(name,birthdate,doctor_id) VALUES ('#{@name}', '#{@birthdate}', '#{@doctor_id}') RETURNING id;").first['id'].to_i
  end

  # def delete
  #   DB.exec("DELETE FROM doctor where name = '#{@name}';")
  # end

  # def update_name(new_name)
  #   DB.exec("UPDATE doctor SET name = '#{new_name}' WHERE name = '#{@name}';")
  #   @name = new_name
  # end

  # def update_specialty_id(new_specialty_id)
  #   DB.exec("UPDATE doctor SET specialty_id = #{new_specialty_id} WHERE specialty_id = '#{@specialty_id}';")
  #   @specialty_id = new_specialty_id
  # end

  # def update_insurance_id(new_insurance_id)
  #   DB.exec("UPDATE doctor SET insurance_id = '#{new_insurance_id}' WHERE name = '#{@insurance_id}';")
  #   @insurance_id = new_insurance_id
  # end

end


