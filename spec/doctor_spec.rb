require 'spec_helper'

describe 'Doctor' do

  it 'initilizes with name, specialty_id and insurance_id' do
    new_doctor = Doctor.new(ATTRIBUTES)
    expect(new_doctor).to be_a Doctor
    expect(new_doctor.name).to eq 'name'
  end

  it 'starts off with no doctors' do
    expect(Doctor.all).to eq []
  end

  it 'makes Doctor objects with same name equal eachother' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor2 = Doctor.new(ATTRIBUTES)
    expect(new_doctor).to eq new_doctor2
  end

  it 'lets you save doctors to the database and pull down doctors and list them' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    expect(Doctor.all).to eq [new_doctor]
  end

  it 'lets you update a doctors name, specialty, and/or insurance' do
    new_specialty = Specialty.new(ATTRIBUTES)
    new_specialty.save
    new_insurance = Insurance.new(ATTRIBUTES)
    new_insurance.save
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    new_doctor.update_name('update_name')
    new_doctor.update_specialty_id(1)
    new_doctor.update_insurance_id(1)
    expect(new_doctor.name).to eq 'update_name'
    expect(new_doctor.specialty_id).to eq 1
    expect(new_doctor.insurance_id).to eq 1
  end

  it 'lets you delete a doctor record' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    new_doctor.delete
    expect(Doctor.all).to eq []
  end

  it 'returns number of patients for a given doctor' do
    new_doctor1 = Doctor.new(ATTRIBUTES)
    new_doctor1.save
    new_doctor2 = Doctor.new(ATTRIBUTES)
    new_doctor2.save
    new_doctor3 = Doctor.new(ATTRIBUTES)
    new_doctor3.save
    new_patient1 = Patient.new({"name" => 'n1', "doctor_id" => new_doctor2.id.to_i})
    new_patient1.save
    new_patient2 = Patient.new({"name" => 'n2', "doctor_id" => new_doctor3.id.to_i})
    new_patient2.save
    new_patient3 = Patient.new({"name" => 'n3', "doctor_id" => new_doctor3.id.to_i})
    new_patient3.save
    expect(new_doctor1.patient_counter).to eq '0'
    expect(new_doctor2.patient_counter).to eq '1'
    expect(new_doctor3.patient_counter).to eq '2'
  end

   it 'returns list of doctors and thier number of patients' do
    new_doctor1 = Doctor.new({"name" => 'doctor1'})
    new_doctor1.save
    new_doctor2 = Doctor.new({"name" => 'doctor2'})
    new_doctor2.save
    new_doctor3 = Doctor.new({"name" => 'doctor3'})
    new_doctor3.save
    new_patient1 = Patient.new({"name" => 'n1', "doctor_id" => new_doctor2.id.to_i})
    new_patient1.save
    new_patient2 = Patient.new({"name" => 'n2', "doctor_id" => new_doctor3.id.to_i})
    new_patient2.save
    new_patient3 = Patient.new({"name" => 'n3', "doctor_id" => new_doctor3.id.to_i})
    new_patient3.save
    expect(Doctor.patient_count == {"doctor1"=>"0", "doctor2"=>"1", "doctor3"=>"2"}).to eq true
  end

  it 'shows amount doctor billed in a specific date range' do
    new_doctor1 = Doctor.new({"name" => 'doctor1'})
    new_doctor1.save
    new_doctor2 = Doctor.new({"name" => 'doctor2'})
    new_doctor2.save
    new_doctor3 = Doctor.new({"name" => 'doctor3'})
    new_doctor3.save
    new_patient1 = Patient.new({"name" => 'n1', "doctor_id" => new_doctor2.id.to_i})
    new_patient1.save
    new_patient2 = Patient.new({"name" => 'n2', "doctor_id" => new_doctor3.id.to_i})
    new_patient2.save
    new_patient3 = Patient.new({"name" => 'n3', "doctor_id" => new_doctor3.id.to_i})
    new_patient3.save
    new_appointment1 = Appointment.new({'patient_id' => new_patient1.id.to_i, 'doctor_id' => new_doctor1.id.to_i, 'date' => '2014-01-01', 'cost' => '$10.00' })
    new_appointment1.save
    new_appointment2 = Appointment.new({'patient_id' => new_patient2.id.to_i, 'doctor_id' => new_doctor2.id.to_i, 'date' => '2015-01-01', 'cost' => '$20.00'})
    new_appointment2.save
    new_appointment3 = Appointment.new({'patient_id' => new_patient3.id.to_i, 'doctor_id' => new_doctor3.id.to_i, 'date' => '2016-01-01', 'cost' => '$30.00' })
    new_appointment3.save
    new_appointment4 = Appointment.new({'patient_id' => new_patient1.id.to_i, 'doctor_id' => new_doctor2.id.to_i, 'date' => '2014-01-01', 'cost' => '$10.00' })
    new_appointment4.save
    new_appointment5 = Appointment.new({'patient_id' => new_patient2.id.to_i, 'doctor_id' => new_doctor3.id.to_i, 'date' => '2015-01-01', 'cost' => '$20.00'})
    new_appointment5.save
    new_appointment6 = Appointment.new({'patient_id' => new_patient3.id.to_i, 'doctor_id' => new_doctor3.id.to_i, 'date' => '2016-01-01', 'cost' => '$30.00' })
    new_appointment6.save
    expect(new_doctor1.billed('2013-01-01', '2015-01-01')).to eq '$10.00'
    expect(new_doctor2.billed('2014-01-01', '2015-01-01')).to eq '$30.00'
    expect(new_doctor3.billed('2016-01-01', '2016-01-01')).to eq '$60.00'

  end
end
