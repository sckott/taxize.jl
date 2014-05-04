module Taxize
  using Requests, JSON, LightXML

  export itisPing, gettaxonomicranknamefromtsn

  """
  itisPing - ping the ITIS server and get some metadata on the service

  Usage:

    Taxize.itisPing()
  """
  function itisPing()
    temp = Requests.get("http://www.itis.gov/ITISWebService/services/ITISService/getDescription")
    return temp.data
  end

  """
  Returns the kingdom and rank information for the TSN.

  :param tsn: TSN for a taxonomic group (numeric)

  Usage:
  Taxize.gettaxonomicranknamefromtsn(tsn = 202385)
  """
  function gettaxonomicranknamefromtsn(tsn)
    url = "http://www.itis.gov/ITISWebService/services/ITISService/getTaxonomicRankNameFromTSN"
    payload = {"tsn" => tsn}
    out = Requests.get(url; query = payload)
    check_status(out)
    dat = out.data
    return replace(replace(dat, "\r", ""), "\n", "")
  end

  function gni_parse(names)
    """
    Uses the Global Names Index to parse scientific names

    :param names: List of scientific names.

    Usage:
    Taxize.gni_parse(names = ("Cyanistes caeruleus","Helianthus annuus"))
    """
    url = "http://gni.globalnames.org/parsers.json"
    names = join(names, "|")
    out = Requests.get(url; query = {"names" => names})
    check_status(out)
    return out.data
  end

  function check_status(response_obj)
    if response_obj.status > 200
      @sprintf("Call error, http status code: %s", response_obj.status)
    end
  end

end
