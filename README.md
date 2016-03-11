#Presidential Campaign Finance Tracker

The Campaign Finance Tracker leverges data sourced from the Propublica Campaign Finanace API (<http://propublica.github.io/campaign-finance-api-docs/#campaign-finance-api-documentation>), and focuses (for now) on the candidates running in the 2016 Presidential Election. Where politicians are receiving the money that funds their expensive election campaigns, and how that money will influence their policy when elected has become an issue of great importance for voters. Using this app you will be able to view basic statistics on the fundraising of each candidates campaign, a state by state breakdown of fundraising to date, and a breakdown of the candidates donations by donation level.

If you'd like to contribute or fork this project, read below.

#Getting Started 

Campaign Finance Tracker is an interactive web application hosted by <http://www.shinyapps.io/> that presents visuals built from Propublica.org's data. 

- `scripts/` directory contains the Rscripts that query, save, and present these data. 
- `data/` directory is where this information is stored in the form of .csv files. 
- `text/` directory holds text that is hosted in the final web application.


##Query Propublica's API

To get started querying your own data, request an API key from apihelp@propublica.org and take a look at `scripts/data-retrieval.r` Three functions for querying the API are included in this file:

- `queryCandidateData(id, campaign_cylce)` 
- `queryCampaignData(campaign_cycle)`
- `queryStateData(campaign_cycle, state)`

These are saved as .csv files in the `data/` directory. To use this data within a R session, see **Using Saved Data**. An id is a unique alpha-numeric string assigned to each candidate. FEC IDs can be found at <http://www.fec.gov/finance/disclosure/candcmte_info.shtml>

##Using Saved Data

`data-retrieval.r` contains several functions that return dataframes built from previously saved data. These functions are:

- `getCandidateData(candidate_list, campaign_cycle)`
- `aggCampaignData(campaign_cycle, candidate_list)`
- `aggStateData(campaign_cycle)`

You must either run the corresponding `query....()` function before calling one of these functions or download data as .csv and save to `data/`.
