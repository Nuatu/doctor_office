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

  it 'returns a hash with doctor id, name, and number of patients' do
    new_doctor1 = Doctor.new(ATTRIBUTES)
    new_doctor1.save
    new_doctor2 = Doctor.new(ATTRIBUTES)
    new_doctor2.save
    new_doctor3 = Doctor.new(ATTRIBUTES)
    new_doctor3.save
    new_patient1 = Patient.new({"name" => 'n1', "doctor_id" => new_doctor2.id.to_i})
    new_patient2 = Patient.new({"name" => 'n2', "doctor_id" => new_doctor3.id.to_i})
    new_patient3 = Patient.new({"name" => 'n3', "doctor_id" => new_doctor3.id.to_i})
    expect(new_doctor1.patient_count).to eq '0'
    expect(new_doctor2.patient_count).to eq '1'
    expect(new_doctor3.patient_count).to eq '2'
  end
end
