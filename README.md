# RunReveal Starter Pack
1. [Queries](#queries)
2. [Triggers](#triggers)

# Queries
## AWS
#### Access Denied
Usage:
```
runreveal logs --name access-denied
```
The `access-denied` query will search your Cloudtrail logs for instances that a user or role were blocked from performing an action due to their permissions.

A sudden increase or change in the results of this query is notable and can indicate a compromised account, or someone who may be struggling with IAM.

#### Access Key Usage
Usage:
```
runreveal logs --name access-key-usage
```
The `access-key-usage` query will provide an overview of the past 5 minute usage of access keys, and by which IAM users.

This query will show which users are making which API calls, and how many of them. A sudden increase in the quantity of access, or a sudden change in eventNames might indicate a compromised account or misuse of an AWS key.

#### AWS key timeline
Usage:
```
runreveal logs --name aws-key-timeline --param key=AKIAZZZZZZ --param since=24
```
This has two parameters
`key` -  Is used to specify which AWS key you'd like to generate a timeline.
`since` - Is used to specify the number of hours into the past that you want to generate the timeline for.

This query is very useful for quickly seeing a exactly what an AWS key has been used for over a specific duration of time.

#### Failed logins
Usage:
```
runreveal logs --name failed-login-attempts
```

Quickly see a list of failed logins, and from which IP, AS number, and country that the attempt originated from. This is useful in quickly identifying attempted unauthorized access to your AWS account.

#### Secret access
Usage:
```
runreveal logs --name secret-access
```
List the secrets that have been accessed through secrets manager, and by whom, over the past two hours.

#### Unknown Console Login
Usage:
```
runreveal logs --name unknown-console-login
```
Show recent logins to the AWS console and see if the authenticated user has logged in from that geography before. This will show when a user's geography has rapidly changed, and is a useful query to run on scheduled queries.

## GSuite
#### Access by country
Usage:
```
runreveal logs --name access-by-country --param country=US --param hour=1
```
Show what access has come from a specific country over a specific timeframe. This query in particular is useful to run on a schedule to look for access from high risk countries that you don't expect to be accessing your systems or docs.

#### Externally shared drive docs
Usage:
```
runreveal logs --name externally-shared-drive-docs
```
Show who in your organization has shared docs that are publicly accessible. Useful to run on a schedule to see differences and changes over time. Useful in detecting people leaving your company who may try to take souvenirs. 

## Generic Queries
#### User events
Usage:
```
runreveal logs --name user-events --param email=evan@runreveal.com --param hour=5
```
This will show you what a specific user has done over a specific timeframe.

#### Higher average trigger usage
Usage:
```
runreveal logs --name higher-avg-trigger-usage
```

This will show you triggers that are firing at a higher than average rate. Critical for detecting changes in your environment.



1. 
# Triggers