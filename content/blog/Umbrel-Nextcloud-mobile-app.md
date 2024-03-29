title=How to plug your Umbrel's Nextcloud into the official Nextcloud mobile app?
date=2022-08-21T11:26:50Z
type=post
tags=umbrel, nextcloud, tailscale
status=published
~~~~~~

## Why you could want to do that?

You could want to use the Nextcloud app to make saving your phone data easier or to get documents from your cloud easily (without a Tor browser, connect via onion etc.).

## Why is it not possible natively?

It's impossible to connect the Nextcloud app to a onion address, you need a clear-net URL. We will use Tailscale to solve this problem.

## What is Tailscale?

Tailscale is a zero-config VPN. The easiest way to create a secure network between your servers, computers, and cloud instances. We will use Tailscale to connect Umbrel's Nextcloud to your mobile with clear-net (or any other device).
https://github.com/tailscale/tailscale

## Install Tailscale on your devices

- Umbrel: Go to your umbrel (directly http://umbrel.local, not using onion because Tailescale doesn’t work - for me - using tor connection). Install the app via the App Store.
- Phone: Install the Tailscale app via the Google/Apple Store.
- Computer: https://tailscale.com/

Create a Tailscale account, and connect all your devices on this account.

## Configure new trusted domain on your Nextcloud app

Connect via ssh on your umbrel :

```
ssh umbrel@umbrel.local
```

Find the ID of the Nexcloud container :

```
docker ps
```

Pick the ID of the service started with `/entrypoint.sh apac…`

Enter this command, to add your nextcloud Tailscale address as truster_domain :

```
docker exec --user www-data ID_OF_THE_NEXTCLOUD_CONTAINER php occ config:system:set trusted_domains 3 --value=IP_OF_YOUR_UMBREL_ON_TAILSCALE
```

### Enjoy!

Now, you can enter the Tailscale IP of your umbrel with the port on the Nextcloud App.

⚠️ Don't use SSL → HTTP instead HTTPS
