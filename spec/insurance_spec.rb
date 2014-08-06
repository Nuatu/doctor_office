require 'spec_helper'

describe 'Insurance' do

  it 'initilizes with name, and id' do
    new_insurance = Insurance.new(ATTRIBUTES)
    expect(new_insurance).to be_a Insurance
    expect(new_insurance.name).to eq 'name'
    expect(new_insurance.id).to eq nil
  end

  it 'makes Insurance objects with same name equal eachother' do
    new_insurance = Insurance.new(ATTRIBUTES)
    new_insurance1 = Insurance.new(ATTRIBUTES)
    expect(new_insurance).to eq new_insurance1
  end

  it 'will save a Insurance object to the database showing through list' do
    new_insurance = Insurance.new(ATTRIBUTES)
    new_insurance.save
    expect(Insurance.all).to eq [new_insurance]
  end

  it 'lets you update a Insurance name' do
    new_insurance = Insurance.new(ATTRIBUTES)
    new_insurance.save
    new_insurance.update_name('update_name')
    expect(new_insurance.name).to eq 'update_name'
  end

  it 'Insurance object deletes itself' do
    new_insurance = Insurance.new(ATTRIBUTES)
    new_insurance.save
    new_insurance.delete
    expect(Insurance.all).to eq []
  end

end
