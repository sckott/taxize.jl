module Taxize
  using Requests
  using JSON

  function itisPing()
    temp = Requests.get("http://www.itis.gov/ITISWebService/services/ITISService/getDescription")
    return temp.data
  end

end
