describe Rubyflare::Response do

  let(:method_name) { :get }
  let(:endpoint) { 'user' }
  let(:response) { { success: true }.to_json }
  subject { described_class.new(method_name, endpoint, response) }

  describe '#initialize' do

    context 'with a successful response' do
      it "returns an instance of #{described_class}" do
        expect(subject).to be_a described_class
      end
    end

    context 'with an unsuccessful response' do
      let(:response) { {"success":false,"errors":[{"code":7000,"message":"No route for that URI"}],"messages":[],"result":nil}.to_json }

      it 'raises a Rubyflare::ConnectionError' do
        expect { subject }.to raise_error(Rubyflare::ConnectionError)
      end

      it 'returns the error message' do
        expect { subject }.to raise_error(StandardError, "Unable to GET to endpoint: user. No route for that URI")
      end
    end
  end
end
