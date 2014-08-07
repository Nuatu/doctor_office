require 'spec_helper'

describe 'Patient' do

  it 'initilizes with name, birthdate and doctor_id' do
    new_patient = Patient.new(ATTRIBUTES)
    expect(new_patient).to be_a Patient
    expect(new_patient.name).to eq 'name'
  end

  it 'starts off with no patients' do
    expect(Patient.all).to eq []
  end

  it 'makes Patient objects with same name equal eachother' do
    new_patient = Patient.new(ATTRIBUTES)
    new_patient2 = Patient.new(ATTRIBUTES)
    expect(new_patient).to eq new_patient2
  end

  it 'lets you save patients to the database and pull down patients and list them' do
    new_patient = Patient.new(ATTRIBUTES)
    new_patient.save
    expect(Patient.all).to eq [new_patient]
  end

  it 'lets you update a patients name, birthdate, and/or doctor_id' do
    new_doctor = Doctor.new(ATTRIBUTES)
    new_doctor.save
    new_patient = Patient.new(ATTRIBUTES)
    new_patient.save
    new_patient.update_name('update_name')
    new_patient.update_doctor_id(1)
    new_patient.update_birthdate('1988-01-01')
    expect(new_patient.name).to eq 'update_name'
    expect(new_patient.doctor_id).to eq 1
    expect(new_patient.birthdate).to eq '1988-01-01'
  end

  it 'lets you delete a patient record' do
    new_patient = Patient.new(ATTRIBUTES)
    new_patient.save
    new_patient.delete
    expect(Patient.all).to eq []
  end

  it 'lets you search for a patient by name' do
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
    expect(Patient.search('n1') == new_patient1).to eq true
  end
end
