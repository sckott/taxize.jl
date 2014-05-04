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
  function gettaxonomicranknamefromtsn(tsn):
    url = "http://www.itis.gov/ITISWebService/services/ITISService/getTaxonomicRankNameFromTSN"
    payload = {"tsn" => tsn}
    out = Requests.get(url; query = payload)

    if out.status > 200
      @sprintf("Call error, http status code: %s", out.status)
    end

    dat = out.data
    return replace(replace(dat, "\r", ""), "\n", "")
    # xmlparser = etree.XMLParser()
    # tt = etree.fromstring(out.content, xmlparser)
    #
    # ns = {"ax21":"http://data.itis_service.itis.usgs.gov/xsd"}
    # ss_nodes = tt.xpath("//ax21:*", namespaces=ns)
    # vals = [x.text for x in ss_nodes]
    # keys = [x.tag.split("}")[1] for x in ss_nodes]
    # # df = pd.DataFrame([dict(zip(keys, vals))])
    # df = dict(zip(keys, vals))
    # return df
  end

end
