*** Exchange Function ***

- Takes all CSV files in the "ToConvert" directory
- Creates a new CSV file for each one in the "Converted" directory
- The new CSV's have only the id, initial_value, initial_currency and euro_value columns
- The euro_value column is generated through the "https://exchangeratesapi.io/" API

### Instructions ###

1. Ensure you have Ruby version 2.6.8 or later installed. Run this commany to see which version you are running ```ruby -v``` 
2. If you dont have it already install ruby here -- "https://www.ruby-lang.org/en/documentation/installation/"
3. You will need to get your own free API key from here "https://exchangeratesapi.io/" click on the Get Free API Key and paste onto line 50 of exchange-function.rb
3. Now you can add any files you want to convert in to the "ToConvert" directory. We have 3 in there already
4. In the terminal run ``` ruby exchange_function.rb ``` to execute the conversion. 
5. You should see your converted files apear in the "Converted" directory!
6. Tests can be run by runing ``` ruby __Tests__/update_row.test.rb ```


## Additional Comments ##
- This method could be improved and optomised by creating more threads for the  asynchronous calls to the API instead of awaiting a responce before continuing. I came across a couple of docs while researching "Sidekiq" ond "async/http/internet" but i'm sure there are many packages that help with asynchronous tasks without having to create threads.

- An obvious limitation is the number of credits on each account for the API. 

- Another point worth mentioning is that the API key should never be stored in production code. Most cloud hosting platforms have their own version of a vault to store such "secrets" in when code makes it to production. 

- Given more time I would improve unit test coverage to ensure all potential errors are handled and any side effects/bugs dealt with. 



