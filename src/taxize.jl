module Taxize
  using Requests
  using JSON

  export itisPing

  """
  Some notes

  Usage:
    Taxize.itisPing()
  """
  function itisPing()
    temp = Requests.get("http://www.itis.gov/ITISWebService/services/ITISService/getDescription")
    return temp.data
  end

end
