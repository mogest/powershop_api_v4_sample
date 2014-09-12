# A sample app that uses the Powershop v4 API

To have a go with this demo yourself, edit config/secrets.yml and change the <tt>oauth_client_id</tt> and <tt>oauth_secret</tt> to match the
values you get from the Powershop app (see below.)

## Basic API documentation

This stuff is brand new as of the last 48 hours, so you're playing with cutting edge stuff.  Unfortunately, this
means the documentation is sparse.  We're on hand to help out if you need us, just look for anyone from Powershop.

There are two bits to the API:

1) You can get half hour data (also known as time of use data) for a particular consumer (or electricity connection).  This will show you
how much electricity a particular customer has used over a period of time, down to half-hour resolution.

2) You can get aggregated averaged half hour data on the *NSP* level.  This gives you an idea about how much
electricity the average customer in a given geographical region uses.

An *NSP* is an area that is delivered power from a single substation.  For example, if you live in central
Wellington, you are probably serviced by the "CKHK CPK0331 GN" NSP, otherwise known as the Central Park substation.

### Authentication

**You don't need OAuth to get aggregate, averaged power usage data for the country.**  But if you want to get the half hour data of one of our test accounts, you will need OAuth set up.

Go to http://hackfest.powershop.com/oauth/applications to register your application.  This gives you a client ID and secret.

Then configure your OAuth client library with the ID/secret and to hit the following URLs:

    Authorize URL: http://hackfest.powershop.com/oauth/authorize
    Token URL: http://hackfest.powershop.com/oauth/token

When you're asked to log in to Powershop, log in with email address <tt>user_2@test.powershop.co.nz</tt> and
password <tt>hackfest</tt>.

### GET http://hackfest.powershop.com/api/v4/nsps

Public, no authorisation required.

No parameters.

Returns a list of NSPs, including their physical locations.

### GET http://hackfest.powershop.com/api/v4/nsps/[nsp_id]/aggregated_time_of_use_readings

Public, no authorisation required.

Parameters are <tt>start_date</tt> and <tt>end_date</tt> in yyyy-mm-dd format.

Returns a hash where the keys are dates and the values are an array of 48 integers.  Each integer shows the average
amount of electricity used (in watt-hours) for Powershop customers in the specified NSP in that half hour of the day,
the first being 00:00 to 00:30 and the last being 23:30 to 00:00.

### GET http://hackfest.powershop.com/api/v4/consumers

Requires OAuth access token.

Optional parameter is <tt>filter</tt> which may be set to <tt>active</tt> to only return active consumers.

Returns a list of consumers (properties or electricity connections) that the currently authenticated user has on
their account.

### GET http://hackfest.powershop.com/api/v4/consumers/[consumer_id]/time_of_use_readings

Requires OAuth access token.

Parameters are <tt>start_date</tt> and <tt>end_date</tt> in yyyy-mm-dd format.

Returns a hash where the keys are dates and the values are an array of 48 integers.  Each integer shows the
amount of electricity used (in watt-hours) by the specified consumer in that half hour of the day, the first being
00:00 to 00:30 and the last being 23:30 to 00:00.
