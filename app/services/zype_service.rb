class ZypeService
  attr_accessor :access_token

  def initialize(access_hash = nil)
    @access_token = access_hash["access_token"] if access_hash
  end

  def authenticate!(client_id, client_secret, username, password)
    response = Faraday.post("https://login.zype.com/oauth/token") do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['username'] = username
      req.params['password'] = password
      req.params['grant_type']="password"
      req.params['Accept']='application/json'
    end
    access_hash = JSON.parse(response.body)
    @access_token = access_hash["access_token"]
  end

  def get_videos_json_from_api(page= '1')
    resp = Faraday.get('https://api.zype.com/videos?app_key=XWny5j0V89yb1uZu6SI_D95EADV5FzBYldE9Ny0_q0GOzcWLiruPyhN-f2Pcyohf')
    JSON.parse(resp.body)["response"]
  end

  def create_videos_from_api(page='1')
    get_videos_json_from_api(page).map do |vid|
    Video.new(vid)
    end
  end
end