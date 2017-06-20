require_relative "../spec_helper.rb"

shared_examples 'a valid student' do
  it {expect(subject.name).to eql("John A")}
  it {expect(subject.age).to be_between(18, 38)}
  it {expect(subject.login).to eql("JA")}
  it {expect(subject.password).to eql("JA")}
  it {expect(subject.region).to eql("RJ (BR)")}
  it {expect(subject.email).to eql ("xuxu@gmail.com")}
  it {expect(subject.phone).to eql ("000")}
end



describe University::Student do
  before :each do
    response = double
    allow(response).to receive(:body) { <<eos
{"results":[{"gender":"male","name":{"title":"ms","first":"John","last":"A"},"location":{"street":"5833 avenida vinícius de morais","city":"Rio de Janeiro","state":"RJ","postcode":46166},"email":"xuxu@gmail.com","login":{"username":"JA","password":"JA","salt":"rAhg2Aiy","md5":"79a6ba6e243b4aa74fdc67d3e1d3bc3e","sha1":"88f7f3104ac337ae9bd1239aac1cea43149a0609","sha256":"f33bb43b3f356a5f75631f615353c3b497deaaa3c7b2b44dc786c6918cdf4408"},"dob":"1987-07-18 00:46:18","registered":"2009-02-23 14:01:49","phone":"000","cell":"(78) 3104-5225","id":{"name":"","value":null},"picture":{"large":"https://randomuser.me/api/portraits/women/13.jpg","medium":"https://randomuser.me/api/portraits/med/women/13.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/women/13.jpg"},"nat":"BR"}],"info":{"seed":"a411f39c662ca094","results":1,"page":1,"version":"1.1"}}
eos
}
    allow(RestClient).to receive(:get).with(any_args) {response}
  end

  after :each do
    subject.delete
  end




  context "when get student get by api" do
    subject {University::Student.create_students_from_api.first}
    it_behaves_like "a valid student"
  end
    
  let(:hash_student) {
       {"name"=>{"first"=>"John", "last"=>"A"}, "login"=>{"username"=>"JA", "password"=>"JA"}, "location"=>{"state"=>"RJ"}, "nat"=>"BR", "email"=>"xuxu@gmail.com", "phone"=>"000"}
  }
      
  context "when student is create by hash" do
    subject {University::Student.hash_to_student hash_student}
    it_behaves_like "a valid student"
  end
end
