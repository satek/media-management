describe User do

  context "when no role provided" do
    subject { FactoryGirl.create :user }
    it "sets a default user role" do
      expect(subject.role).to eq("user")
    end
  end

  context "when user role is not present" do
    subject { FactoryGirl.build :user, role: nil }
    it "has an error on role field" do
      is_expected.to have(1).errors_on :role
    end
  end

  context "when email is invalid" do
    context "when nil" do
      subject { FactoryGirl.build :user, email: nil }
      it { is_expected.to have(1).errors_on(:email) }
    end
    context "when empty" do
      subject { FactoryGirl.build :user, email: '' }
      it { is_expected.to have(1).error_on :email }
    end
  end

  context "when invalid role is being assigned" do
    subject { FactoryGirl.build :user }
    it "raises an error" do
      expect {
        subject.role = :nonexistent
      }.to raise_error(ArgumentError)
    end
  end

end
