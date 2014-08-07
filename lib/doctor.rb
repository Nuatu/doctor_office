class Doctor
  attr_accessor :name, :specialty_id, :insurance_id, :id

  def initialize(attributes)
    @name = attributes['name']
    @specialty_id = attributes['specialty_id']
    @insurance_id  = attributes['insurance_id']
    @id = attributes['id']
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def self.all
    doctors = []
    results = DB.exec("SELECT * FROM doctor;")
    results.each do |result|
      doctors << Doctor.new(result)
    end
    doctors
  end

  def patient_counter
    DB.exec("SELECT COUNT(*)FROM patient WHERE doctor_id = '#{@id}';").first['count']
  end

  def self.patient_count
    doctors_patients = {}
    doctors = self.all
    doctors.each do |doctor|
      doctors_patients.store(doctor.name, doctor.patient_counter)
    end
    doctors_patients
  end

  def save
    if @specialty_id == nil
      @id = DB.exec("INSERT INTO doctor(name, specialty_id, insurance_id) VALUES ('#{@name}', null, null) RETURNING id;").first['id'].to_i
    else
      @id = DB.exec("INSERT INTO doctor(name, specialty_id, insurance_id) VALUES ('#{@name}', '#{@specialty_id}', '#{@insurance_id}') RETURNING id;").first['id'].to_i
    end
  end

  def delete
    DB.exec("DELETE FROM doctor where id = '#{@id}';")
  end

  def update_name(new_name)
    DB.exec("UPDATE doctor SET name = '#{new_name}' WHERE id = '#{@id}';")
    @name = new_name
  end

  def update_specialty_id(new_specialty_id)
    DB.exec("UPDATE doctor SET specialty_id = '#{new_specialty_id}' WHERE id = '#{@id}';")
    @specialty_id = new_specialty_id
  end

  def update_insurance_id(new_insurance_id)
    DB.exec("UPDATE doctor SET insurance_id = '#{new_insurance_id}' WHERE id = '#{@id}';")
    @insurance_id = new_insurance_id
  end

  def billed(date1, date2)
    DB.exec("SELECT SUM(cost) FROM appointment WHERE date BETWEEN TO_DATE ('#{date1}', 'yyyy/mm/dd') AND TO_DATE ('#{date2}', 'yyyy/mm/dd') AND doctor_id = '#{@id}';").first['sum']
  end
end


