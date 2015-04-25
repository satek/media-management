describe User do

  before(:each) { @user = FactoryGirl.create :user }

  subject { @user }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  it "has a has a default user role" do
    expect(subject.role).to eq("user")
  end

  it "is invalid without email" do
    subject.email = ''
    expect(subject.valid?).to be false
  end

  it "is invalid without name" do
    subject.name = ''
    expect(subject.valid?).to be false
  end

  it "it accepts only valid roles" do
    expect {
      subject.role = :nonexistent
    }.to raise_error(ArgumentError)
  end

end
