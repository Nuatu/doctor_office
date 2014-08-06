require 'spec_helper'

describe 'Doctor' do

  it 'initilizes with name, specialty_id and insurance_id' do
    new_specialty = Specialty.new('name')
    new_specialty.save
    new_insurance = Insurance.new('name')
    new_insurance.save
    new_doctor = Doctor.new('name', new_specialty.id.to_i, new_insurance.id.to_i)
    expect(new_doctor).to be_a Doctor
    expect(new_doctor.name).to eq 'name'
    expect(new_doctor.specialty_id.class).to eq Fixnum
    expect(new_doctor.insurance_id.class).to eq Fixnum
  end

  it 'starts off with no doctors' do
    expect(Doctor.all).to eq []
  end

  it 'makes Doctor objects with same name equal eachother' do
    new_specialty = Specialty.new('name')
    new_specialty.save
    new_insurance = Insurance.new('name')
    new_insurance.save
    new_doctor = Doctor.new('name', new_specialty.id.to_i, new_insurance.id.to_i)
    new_doctor2 = Doctor.new('name', new_specialty.id.to_i, new_insurance.id.to_i)
    expect(new_doctor).to eq new_doctor2
  end

  it 'lets you save doctors to the database and pull down doctors and list them' do
    new_specialty = Specialty.new('name')
    new_specialty.save
    new_insurance = Insurance.new('name')
    new_insurance.save
    new_doctor = Doctor.new('name', new_specialty.id.to_i, new_insurance.id.to_i)
    new_doctor.save
    expect(Doctor.all).to eq [new_doctor]
  end

  it 'lets you update a doctors name, specialty, and/or insurance' do
    new_specialty = Specialty.new('name')
    new_specialty.save
    new_insurance = Insurance.new('name')
    new_insurance.save
    new_doctor = Doctor.new('name', new_specialty.id.to_i, new_insurance.id.to_i)
    new_doctor.save
    new_doctor.update_name('update_name')
    new_doctor.update_specialty_id(1)
    new_doctor.update_insurance_id(1)
    expect(new_doctor.name).to eq 'update_name'
    expect(new_doctor.specialty_id).to eq 1
    expect(new_doctor.insurance_id).to eq 1
  end

  it 'lets you delete a doctor record' do
    new_specialty = Specialty.new('name')
    new_specialty.save
    new_insurance = Insurance.new('name')
    new_insurance.save
    new_doctor = Doctor.new('name', new_specialty.id.to_i, new_insurance.id.to_i)
    new_doctor.save
    new_doctor.delete
    expect(Doctor.all).to eq []
  end

end
