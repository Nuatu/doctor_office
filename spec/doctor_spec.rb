require 'spec_helper'

describe 'Doctor' do

  it 'initilizes with name, specialty and insurance' do
    new_doctor = Doctor.new('name', 'specialty', 'insurance')
    expect(new_doctor).to be_a Doctor
    expect(new_doctor.name).to eq 'name'
    expect(new_doctor.specialty).to eq 'specialty'
    expect(new_doctor.insurance).to eq 'insurance'
  end

  it 'starts off with no doctors' do
    expect(Doctor.all).to eq []
  end

  it 'makes Doctor objects with same name equal eachother' do
    new_doctor = Doctor.new('name', 'specialty', 'insurance')
    new_doctor2 = Doctor.new('name', 'specialty', 'insurance')
    expect(new_doctor).to eq new_doctor2
  end

  it 'lets you save doctors to the database and pull down doctors and list them' do
    new_doctor = Doctor.new('name', 'specialty', 'insurance')
    new_doctor.save
    expect(Doctor.all).to eq [new_doctor]
  end

  it 'lets you update a doctors name, specialty, and/or insurance' do
    new_doctor = Doctor.new('name', 'specialty', 'insurance')
    new_doctor.save
    new_doctor.update_name('update_name')
    new_doctor.update_specialty('update_specialty')
    new_doctor.update_insurance('update_insurance')
    expect(new_doctor.name).to eq 'update_name'
    expect(new_doctor.specialty).to eq 'update_specialty'
    expect(new_doctor.insurance).to eq 'update_insurance'
  end

  it 'lets you delete a doctor record' do
    new_doctor = Doctor.new('name', 'specialty', 'insurance')
    new_doctor.save
    new_doctor.delete
    expect(Doctor.all).to eq []
  end

end
