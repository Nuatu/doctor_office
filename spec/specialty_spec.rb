require 'spec_helper'

describe 'Specialty' do

  it 'initilizes with name, and id' do
    new_specialty = Specialty.new(ATTRIBUTES)
    expect(new_specialty).to be_a Specialty
    expect(new_specialty.name).to eq 'name'
    expect(new_specialty.id).to eq nil
  end

  it 'makes Specialty objects with same name equal eachother' do
    new_specialty = Specialty.new(ATTRIBUTES)
    new_specialty1 = Specialty.new(ATTRIBUTES)
    expect(new_specialty).to eq new_specialty1
  end

  it 'will save a Specialty object to the database showing through list' do
    new_specialty = Specialty.new(ATTRIBUTES)
    new_specialty.save
    expect(Specialty.all).to eq [new_specialty]
  end

  it 'lets you update a specialty name' do
    new_specialty = Specialty.new(ATTRIBUTES)
    new_specialty.save
    new_specialty.update_name('update_name')
    expect(new_specialty.name).to eq 'update_name'
  end

  it 'specialty object deletes itself' do
    new_specialty = Specialty.new(ATTRIBUTES)
    new_specialty.save
    new_specialty.delete
    expect(Specialty.all).to eq []
  end

end
