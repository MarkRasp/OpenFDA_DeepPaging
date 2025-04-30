Simple custom connector that connects to a web source, parses the main data returned, also grabs the Link response header via Value.Metadata and then outputs both in record:
```
[Headers = header record, Results = data table]
```
This is designed to be used with [openFDA API](https://open.fda.gov/apis/), but could be used with any api that: 
a) returns results in a Json record with data in a "results" field
b) provides a Link response header with details of query to use to get next page of data

See the test query for an example of how to page through openFDA api, [OpenFDA_DeepPaging.query.pq](OpenFDA_DeepPaging.query.pq)
