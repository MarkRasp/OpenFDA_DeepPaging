// Use this file to write queries to test your data connector
// Test with: https://api.fda.gov/device/510k.json?search=openfda.regulation_number:868.5895&limit=100
// As of 2025-04-29, has 590 total records. With limit=100, we should page through 6 web calls
let
    SourceUrl = "https://api.fda.gov",
    GetAll = List.Generate(
        () =>
            OpenFDA_DeepPaging.Contents(
                SourceUrl, "device/510k.json?search=openfda.regulation_number:868.5895&limit=100"
            ),
        each _ <> null,
        each
            if[Headers][Link]? = null then
                null
            else
                let
                    nextFullCall = Text.BetweenDelimiters([Headers][Link], "<", ">; rel"),
                    endpointAndQuery = Text.AfterDelimiter(nextFullCall, SourceUrl & "/")
                in
                    OpenFDA_DeepPaging.Contents(SourceUrl, endpointAndQuery),
        each [Results]
    ),
    CombineAll = Table.Combine(GetAll)
in
    CombineAll