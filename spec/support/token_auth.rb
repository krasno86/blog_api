RSpec.shared_context "token auth" do
  let(:auth_headers) do
    if respond_to?(:signed_in_user)
      signed_in_user.create_new_auth_token
    else
      {}
    end
  end

  let("access-token") { auth_headers["access-token"] }
  let("token-type") { auth_headers["token-type"] }
  let(:client) { auth_headers["client"] }
  let(:expiry) { auth_headers["expiry"] }
  let(:uid) { auth_headers["uid"] }
end
