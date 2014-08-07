require 'spec_helper'

describe 'Appointment' do

  it 'initilizes with patient_id, doctor_id, date, cost' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    new_patient = Patient.new(ATTRIBUTES)
    new_patient.save
    new_appointment = Appointment.new({'patient_id' => new_patient.id.to_i, 'doctor_id' => new_doctor.id.to_i, 'date' => '2015-01-01' })
    expect(new_appointment).to be_a Appointment
    expect(new_appointment.patient_id == new_patient.id && new_appointment.doctor_id == new_doctor.id && new_appointment.date == '2015-01-01').to eq true
  end

  it 'starts off with no appointments' do
    expect(Appointment.all).to eq []
  end

  it 'makes Appointment objects with same date/doctor_id/patient_id equal eachother' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    new_patient = Patient.new(ATTRIBUTES)
    new_patient.save
    new_appointment = Appointment.new({'patient_id' => new_patient.id.to_i, 'doctor_id' => new_doctor.id.to_i, 'date' => '2015-01-01' })
    new_appointment1 = Appointment.new({'patient_id' => new_patient.id.to_i, 'doctor_id' => new_doctor.id.to_i, 'date' => '2015-01-01' })
    expect(new_appointment).to eq new_appointment1
  end

  it 'lets you save appointments to the database and pull down appointments and list them' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    new_patient = Patient.new(ATTRIBUTES)
    new_patient.save
    new_appointment = Appointment.new({'patient_id' => new_patient.id.to_i, 'doctor_id' => new_doctor.id.to_i, 'date' => '2015-01-01 00:00:00', 'cost' => '$10.00' })
    new_appointment.save
    expect(Appointment.all).to eq [new_appointment]
  end

  it 'lets you update doctor, date, and cost' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    new_patient = Patient.new(ATTRIBUTES)
    new_patient.save
    new_appointment = Appointment.new({'patient_id' => new_patient.id.to_s, 'doctor_id' => new_doctor.id.to_s, 'date' => '2015-01-01 00:00:00' })
    new_appointment.save
    new_appointment.update_doctor_id(1)
    new_appointment.update_date('2016-02-02')
    new_appointment.update_cost('$10.00')
    expect(new_appointment.doctor_id).to eq 1
    expect(new_appointment.date).to eq '2016-02-02'
    expect(new_appointment.cost).to eq '$10.00'
  end

  it 'lets you delete a appointment record' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    new_patient = Patient.new(ATTRIBUTES)
    new_patient.save
    new_appointment = Appointment.new({'patient_id' => new_patient.id.to_i, 'doctor_id' => new_doctor.id.to_i, 'date' => '2015-01-01 00:00:00' })
    new_appointment.save
    new_appointment.delete
    expect(Appointment.all).to eq []
  end

end
