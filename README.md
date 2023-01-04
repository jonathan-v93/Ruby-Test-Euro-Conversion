*** Exchange Function ***

- Takes all CSV files in the "ToConvert" directory
- Creates a new CSV file for each one in the "Converted" directory
- The new CSV's have only the id, initial_value, initial_currency and newly created euro_value columns
- The euro_value column is generated through the "https://exchangeratesapi.io/" API

### Instructions ###

1. Ensure you have Ruby version 2.6.8 or later installed. Run this commany to see which version you are running ```ruby -v``` 
2. If you dont have it already install ruby here -- "https://www.ruby-lang.org/en/documentation/installation/"
3. You will need to get your own free API key from here "https://exchangeratesapi.io/" click on the Get Free API Key. 
4. Create a .env file in the root directory with with your new API key like this ``` API_KEY="ADD API KEY HERE" ```
5. Now you can add any files you want to convert in to the "ToConvert" directory. We have 4 in there already.
6. In the terminal run ``` ruby index.rb ``` to execute the conversion. You should see your converted files apear in the "Converted" directory!
7. Tests can be run by runing ``` ruby __Tests__/update_row.test.rb ```