# Vragen CLI

Command Line Interface to maintain your [vragen-api](https://github.com/MartinMetselaar/vragen-api). You can use this to create, update, delete surveys or export the results from your survey.

## Installation

### macOS

#### Mint
```
$ mint install MartinMetselaar/vragen-cli
```

#### Assets
Download the latest `vragen.zip` from `Releases`. Unzip the `vragen.zip` and move the file to `/usr/local/bin/`.

## Setup
```
$ vragen init --server vragen-api.example.org --token admin-token
```
Replace `vragen-api.example.org` with your server and the `admin-token` with your `ADMIN_TOKEN`.

### Survey
Create a survey
```
$ vragen surveys create --title "First survey"
```
which returns an `UUID` which is the survey id and can be used to create a question. 

Replace `survey-id` with the previous displayed survey id.
```
$ vragen questions create --survey survey-id --title "First question"
```
which returns an `UUID` wich can be used to create an answer.
```
$ vragen answers create --survey survey-id --question question-id --title "First answer"
```

## Help
```
$ vragen --help 
```