# The task is to find and output all of the strings which occur only as a value for the set of keys "about":"name", occuring in JSON below as follows:
#     "about": [
#            {
#              "name": "KeySpan"
#            }
#          ],
#
# In the above example, KeySpan is the value we are interested in. We are not interested in any values which do not occur in "about" followed by "name" keys. Let's call this the about/name value.
#
# We want to count all of the unique strings that are the about/name values in the entire JSON file. Ideally, the output of this task is a dictionary that looks like this:
# {"about/name value1": [2,5,5], "about/name value2": [1,1,3,14]}
#
# The numbers above are the *locations* where the values are found. Locations are identified by an ID key. In the following example, the "location" is the number value at the end of https://api.cognitive.microsoft.com/api/v7/#WebPages string, which in this case is 8:
#      {
#          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.8",
#          "name": "Cookies not enabled",
#          "url": "https://www1.nationalgridus.com/CorporateHub",
#          "about": [
#            {
#              "name": "National Grid plc"
#            }
#          ],
#          "displayUrl": "https://www1.nationalgridus.com/CorporateHub",
#          "snippet": "Thanks for visiting National Grid. We've detected your browser may be blocking cookies which our website requires to access your account. To get the best online ...",
#          "dateLastCrawled": "2018-01-06T22:37:00.0000000Z"
#        }
# In the above example, value "National Grid plc" occurred just one time in location 8.
#
# The following should be the output for the JSON given below:
# {"KeySpan": [0,3], "National Grid plc": [8],
# "Tripp Lite": [9, 9],  "Long Island Power Authority": [13, 13] }


rawJson=r'''{
      "webSearchUrl": "https://www.bing.com/search?q=keyspan+company",
      "totalEstimatedMatches": 385000,
      "value": [
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.0",
          "name": "KeySpan - Wikipedia",
          "url": "https://en.wikipedia.org/wiki/KeySpan",
          "about": [
            {
              "name": "KeySpan"
            }
          ],
          "displayUrl": "https://en.wikipedia.org/wiki/KeySpan",
          "snippet": "KeySpan Corporation, now part of National Grid USA, was the fifth largest distributor of natural gas in the United States. KeySpan was formed in 1998 as a result of ...",
          "dateLastCrawled": "2018-01-06T19:18:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.1",
          "name": "National Grid US - Official Site",
          "url": "https://nationalgridus.com/",
          "displayUrl": "https://nationalgridus.com",
          "snippet": "Welcome to National Grid, providing New York, Rhode Island and Massachusetts with natural gas and electricity for homes and businesses.",
          "deepLinks": [
            {
              "name": "Sign In",
              "url": "https://online.nationalgridus.com/eservice_enu"
            },
            {
              "name": "New York - Long Island",
              "url": "https://www.nationalgridus.com/Upstate-NY-Home/Default"
            },
            {
              "name": "Billing and Payments",
              "url": "https://www.nationalgridus.com/RI-Home/Billing-Payments"
            },
            {
              "name": "Online",
              "url": "https://online.nationalgridus.com/viewmybills/LoginActivate?applicurl=aHR0cHM6Ly9vbmxpbmUubmF0aW9uYWxncmlkdXMuY29tL3ZpZXdteWJpbGxzL215YWNjb3VudC8=&auth_method=0"
            },
            {
              "name": "MA",
              "url": "https://www.nationalgridus.com/MA-Home/Default"
            }
          ],
          "dateLastCrawled": "2018-01-05T00:23:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.2",
          "name": "Keyspan Energy Corporation - The New York Times",
          "url": "https://www.nytimes.com/topic/company/keyspan-energy-corporation",
          "displayUrl": "https://www.nytimes.com/topic/company/keyspan-energy-corporation",
          "snippet": "News about the Keyspan Energy Corporation. Commentary and archival information about the Keyspan Energy Corporation from The New York Times.",
          "dateLastCrawled": "2017-12-29T17:34:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.3",
          "name": "KeySpan Corporation: Private Company Information - Bloomberg",
          "url": "https://www.bloomberg.com/research/stocks/private/snapshot.asp?privcapId=113131",
          "about": [
            {
              "name": "KeySpan"
            }
          ],
          "displayUrl": "https://www.bloomberg.com/research/stocks/private/snapshot.asp?...",
          "snippet": "KeySpan Corporation company research & investing information. Find executives and the latest company news.",
          "dateLastCrawled": "2018-01-02T10:43:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.4",
          "name": "KeySpan Energy Co. -- Company History",
          "url": "http://www.company-histories.com/KeySpan-Energy-Co-Company-History.html",
          "displayUrl": "www.company-histories.com/KeySpan-Energy-Co-Company-History.html",
          "snippet": "At KeySpan Energy, ... KeySpan Energy Co. is a holding company formed by the 1998 merger of Brooklyn Union Gas, the nation's fourth largest natural gas utility, ...",
          "dateLastCrawled": "2017-12-21T10:19:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.5",
          "name": "Keyspan Remotes & Adapters | Tripp Lite",
          "url": "https://www.tripplite.com/products/keyspan-remotes-adapters~24",
          "displayUrl": "https://www.tripplite.com/products/keyspan-remotes-adapters~24",
          "snippet": "Convert older display cables to the newest technology and control presentations remotely in classrooms, conference rooms and auditoriums.",
          "dateLastCrawled": "2018-01-06T20:07:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.6",
          "name": "National Grid (Keyspan New York) - Choose Energy",
          "url": "https://www.chooseenergy.com/utility/national-grid-keyspan-new-york-ny/#!",
          "displayUrl": "https://www.chooseenergy.com/.../national-grid-keyspan-new-york-ny/#!",
          "snippet": "National Grid (Keyspan New York) serves customers all across New York. Learn more about Keyspan New York's rates and \"Price to Compare\" at Choose Energy.",
          "dateLastCrawled": "2018-01-07T05:23:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.7",
          "name": "Long Island NY Gas | National Grid",
          "url": "https://www.nationalgridus.com/Long-Island-NY-Home/Default",
          "displayUrl": "https://www.nationalgridus.com/Long-Island-NY-Home/Default",
          "snippet": "Pay your bill, report gas emergencies, and find useful energy saving and safety tips.",
          "dateLastCrawled": "2018-01-06T16:42:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.8",
          "name": "Cookies not enabled",
          "url": "https://www1.nationalgridus.com/CorporateHub",
          "about": [
            {
              "name": "National Grid plc"
            },
            {
              "notname": "This should not show up"
            }
          ],
          "displayUrl": "https://www1.nationalgridus.com/CorporateHub",
          "snippet": "Thanks for visiting National Grid. We've detected your browser may be blocking cookies which our website requires to access your account. To get the best online ...",
          "dateLastCrawled": "2018-01-06T22:37:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.9",
          "name": "Tripp Lite - Official Site",
          "url": "https://www.tripplite.com/",
          "about": [
            {
              "name": "Tripp Lite"
            },
            {
              "name": "Tripp Lite"
            }
          ],
          "displayUrl": "https://www.tripplite.com",
          "snippet": "ABOUT TRIPP LITE. Tripp Lite is a US-based manufacturer of solutions to power, connect, secure and protect equipment for IT environments. From the largest data center ...",
          "dateLastCrawled": "2018-01-05T18:03:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.10",
          "name": "National Grid Online Login",
          "url": "https://online.nationalgridus.com/eservice_enu",
          "displayUrl": "https://online.nationalgridus.com/eservice_enu",
          "snippet": "Our vision is to become the premier energy and services company in the Northeastern United States. Note: The ... NYC Gas and MA Gas Sign in. All other ...",
          "dateLastCrawled": "2018-01-03T11:03:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.11",
          "name": "KEYSPAN CORP (KSE) SPO - NASDAQ.com",
          "url": "http://www.nasdaq.com/markets/spos/company/keyspan-corp-52024-26411",
          "displayUrl": "www.nasdaq.com/markets/spos/company/keyspan-corp-52024-26411",
          "snippet": "KEYSPAN CORP (KSE) SPO - NASDAQ.com. Hot Topics: ETFs ... Home > Markets > SPOs > Company SPO Overview. KEYSPAN CORP (KSE) SPO. Overview; Financials & Filings;",
          "dateLastCrawled": "2017-12-28T15:58:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.12",
          "name": "KeySpan Corp Company Information - Forbes.com",
          "url": "https://www.forbes.com/lists/2006/18/49337W100.html",
          "displayUrl": "https://www.forbes.com/lists/2006/18/49337W100.html",
          "snippet": "KeySpan Corp background, news, press releases, stock quote, financials, financial ratios, revenues, officers, and additional company information. Financial ...",
          "dateLastCrawled": "2017-12-29T19:52:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.13",
          "name": "Long Island Power Authority - Official Site",
          "url": "http://www.lipower.org/",
          "about": [
            {
              "name": "Long Island Power Authority"
            },
            {
              "name": "Long Island Power Authority"
            }
          ],
          "displayUrl": "www.lipower.org",
          "snippet": "LIPA, a non-profit municipal electric provider, owns the retail electric Transmission and Distribution System on Long Island and provides electric service to Nassau ...",
          "dateLastCrawled": "2018-01-07T20:34:00.0000000Z"
        },
        {
          "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.14",
          "name": "KeySpan Corp: Company Profile - Bloomberg",
          "url": "https://www.bloomberg.com/profiles/companies/KSE:US-keyspan-corp",
          "displayUrl": "https://www.bloomberg.com/profiles/companies/KSE:US-keyspan-corp",
          "snippet": "Company profile & key executives for KeySpan Corp (KSE:-) including description, corporate address, management team and contact info.",
          "dateLastCrawled": "2018-01-07T07:58:00.0000000Z"
        }
      ]
    }'''

# The following should be the output for the JSON given below:
# {"KeySpan": [0,3], "National Grid plc": [8],
# "Tripp Lite": [9, 9],  "Long Island Power Authority": [13, 13] }

import json
# print(rawJson)
data = json.loads(rawJson)
# print(data)
def ayrat_func(input_str:str)->None:
    """print loc"""
    loc_list=[]
    for i in data['value']:
        try:
            for j in i['about']:
                if j['name'] ==input_str:
                    loc_list.append(i['id'][i['id'].rfind('.')+1:])
        except KeyError:
            continue
    print(input_str,loc_list)

ayrat_func('KeySpan')
