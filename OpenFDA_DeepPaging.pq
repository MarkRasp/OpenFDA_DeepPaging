// This file contains your Data Connector logic
[Version = "1.0.0"]
section OpenFDA_DeepPaging;

[DataSource.Kind = "OpenFDA_DeepPaging", Publish = "OpenFDA_DeepPaging.Publish"]
shared OpenFDA_DeepPaging.Contents =
    let
        func = (baseURL as text, optional endpointAndQuery as text) as record =>
            let
                Source = Web.Contents(baseURL, [RelativePath = endpointAndQuery]),
                Headers = Value.Metadata(Source)[Headers],
                Results = Table.FromRecords(Json.Document(Source)[results], null, MissingField.UseNull),
                Return = [Headers = Headers, Results = Results]
            in
                Return
    in
        Value.ReplaceType(
            func, type function (baseURL as text, optional endpointAndQuery as text) as [
                Headers = record, Results = table
            ]
        );

// Data Source Kind description
OpenFDA_DeepPaging = [
    Authentication = [
        // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        Anonymous = []
    ]
];

// Data Source UI publishing description
OpenFDA_DeepPaging.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = OpenFDA_DeepPaging.Icons,
    SourceTypeImage = OpenFDA_DeepPaging.Icons
];

OpenFDA_DeepPaging.Icons = [
    Icon16 = {
        Extension.Contents("OpenFDA_DeepPaging16.png"),
        Extension.Contents("OpenFDA_DeepPaging20.png"),
        Extension.Contents("OpenFDA_DeepPaging24.png"),
        Extension.Contents("OpenFDA_DeepPaging32.png")
    },
    Icon32 = {
        Extension.Contents("OpenFDA_DeepPaging32.png"),
        Extension.Contents("OpenFDA_DeepPaging40.png"),
        Extension.Contents("OpenFDA_DeepPaging48.png"),
        Extension.Contents("OpenFDA_DeepPaging64.png")
    }
];
