class Patient
  attr_accessor :name, :birthdate, :doctor_id, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate = attributes['birthdate']
    @doctor_id = attributes['doctor_id']
    @id = attributes['id']
  end

  def ==(another_patient)
    self.name == another_patient.name
  end

  def self.all
    patients = []
    results = DB.exec("SELECT * FROM patient;")
    results.each do |result|
      patients << Patient.new(result)
    end
    patients
  end

  def save
    if @doctor_id == nil and @birthdate == nil
      @id = DB.exec("INSERT INTO patient(name,birthdate,doctor_id) VALUES ('#{@name}', null, null) RETURNING id;").first['id'].to_i
    elsif @doctor_id == nil
      @id = DB.exec("INSERT INTO patient(name,birthdate,doctor_id) VALUES ('#{@name}', '#{@birthdate}', null) RETURNING id;").first['id'].to_i
    elsif @birthdate == nil
      @id = DB.exec("INSERT INTO patient(name,birthdate,doctor_id) VALUES ('#{@name}', null, '#{@doctor_id}') RETURNING id;").first['id'].to_i
    else
      @id = DB.exec("INSERT INTO patient(name,birthdate,doctor_id) VALUES ('#{@name}', '#{@birthdate}', '#{@doctor_id}') RETURNING id;").first['id'].to_i
    end
  end

  def delete
    DB.exec("DELETE FROM patient where id = '#{@id}';")
  end

  def update_name(new_name)
    DB.exec("UPDATE patient SET name = '#{new_name}' WHERE id = '#{@id}';")
    @name = new_name
  end

  def update_doctor_id(new_doctor_id)
    DB.exec("UPDATE patient SET doctor_id = #{new_doctor_id} WHERE id = '#{@id}';")
    @doctor_id = new_doctor_id
  end

  def update_birthdate(new_birthdate)
    DB.exec("UPDATE patient SET birthdate = '#{new_birthdate}' WHERE id = '#{@id}';")
    @birthdate = new_birthdate
  end

end


