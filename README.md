# DossierStack Docker image

This Docker image provides a running Dossier Stack, which is the backend used
for
[SortingDesk](https://chrome.google.com/webstore/detail/sorting-desk/ikcaehokdafneaiojndpmfbimilmlnid?hl=en-US),
which is a Google Chrome browser extension (Firefox extension coming soon).
In order to use the extension, you will either need to point it at an existing
server or run your own. This Docker image will let you easily run your own.


## Basic usage

Pull the docker image and run it, exposing the HTTP backend on port 8080:

```
docker pull diffeo/dossier-stack:latest
docker run -d --name dossier-stack -p 8080:57312 diffeo/dossier-stack
```

And watch logs with:

```
docker logs -f dossier-stack
```

Finally, you can stop the backend by stopping the container:

```
docker stop dossier-stack
```


### Sorting Desk

Once the backend is running,
[install the SortingDesk browser extension](https://chrome.google.com/webstore/detail/sorting-desk/ikcaehokdafneaiojndpmfbimilmlnid?hl=en-US).
Once installed, go to your browser's extension list ("More tools ->
extensions") and click "Options" in the SortingDesk entry. Once there, select
"local: http://localhost:8080" from the "Active URL" drop down menu and hit the
"Save" button. (If you're running the backend on a different port or host, you
can add/change it in the "Dossier stack URL(s)" field and it will show up in
the "Active URL" menu.)

Once that's done, you should see the SortingDesk popup window appear. Try
adding a folder, then a subfolder and drag an image or a snippet of text from a
web page into that subfolder.

By default, the database is empty so it's unlikely that you'll see good results
appear. We don't yet have a good way of loading data into the backend.


