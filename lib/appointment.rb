class Appointment
  attr_accessor :patient_id, :doctor_id, :date, :id, :cost

  def initialize(attributes)
    @patient_id = attributes['patient_id']
    @doctor_id = attributes['doctor_id']
    @date = attributes['date']
    @id = attributes['id']
    @cost = attributes['cost']
  end

  def ==(another_appointment)
    self.date.to_i == another_appointment.date.to_i and self.patient_id.to_i == another_appointment.patient_id.to_i and self.doctor_id.to_i == another_appointment.doctor_id.to_i
  end

  def self.all
    appointments = []
    results = DB.exec("SELECT * FROM appointment;")
    results.each do |result|
      appointments << Appointment.new(result)
    end
    appointments
  end

  def save
    @id = DB.exec("INSERT INTO appointment(date,doctor_id,patient_id,cost) VALUES ('#{@date}', '#{@doctor_id}', '#{@patient_id}', '#{@cost}') RETURNING id;").first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM appointment where id = '#{@id}';")
  end

  def update_doctor_id(new_doctor_id)
    DB.exec("UPDATE appointment SET doctor_id = #{new_doctor_id} WHERE id = '#{@id}';")
    @doctor_id = new_doctor_id
  end

  def update_date(new_date)
    DB.exec("UPDATE appointment SET date = '#{new_date}' WHERE id = '#{@id}';")
    @date = new_date
  end

  def update_cost(new_cost)
    DB.exec("UPDATE appointment SET cost = '#{new_cost}' WHERE id = '#{@id}';")
    @cost = new_cost
  end

  def billed(date1, date2)
    DB.exec("SELECT SUM(cost) FROM appointment WHERE date BETWEEN TO_DATE ('#{date1}', 'yyyy/mm/dd') AND TO_DATE ('#{date2}', 'yyyy/mm/dd') AND doctor_id = '#{@id}';").first['cost'].to_i
  end

end

# SELECT SUM(cost) FROM appointment WHERE date BETWEEN TO_DATE ('2003/01/01', 'yyyy/mm/dd') AND TO_DATE ('2015/12/31', 'yyyy/mm/dd') AND doctor_id = '1002';
