# [DONE] Install Docker

Add Dockers repository and GPG key

```sh
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

```sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

```sh
 sudo docker run hello-world
```

to Avoid repeated sudo's add user to docker group

```sh
sudo usermod -a -G docker $USER
```


# [DONE] Install Mongosh

Add mongo GPG key

```sh
wget -qO- https://www.mongodb.org/static/pgp/server-8.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-8.0.asc
```

Check Ubuntu and openSSL Version
```sh
lsb_release -dc
openssl version
```
Create source list file
```sh
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
```

APT update
```sh
sudo apt-get update
```
install mongosh with shared openssl3 libraries
```sh
sudo apt-get install -y mongodb-mongosh-shared-openssl3
```

verify
```sh
mongosh --version
```

# [DONE] pull and run MONGO container
Pull Image
```sh
docker pull mongodb/mongodb-community-server:latest
```

```sh
docker run --name mongodb -p 27017:27017 -d mongodb/mongodb-community-server:5.0-ubuntu2004
```

Check container is runnning
```sh
docker container ls
```

connect to container with mongosh
```sh
mongosh --port 27017
```

For authentication of docker image, use 'cosign' (Optional)

# [DONE] Build docker compose.yml
Add mongo service, from mongo image, set to always restart and use standard mongo ports.

```yml
  mongo:
    image: mongo
    restart: always
    ports:
      - 27017:27017
```

Set database credentials and volumes.

```yml
    environment:
      MONGO_INITDB_ROOT_USERNAME: $MONGO_INITDB_ROOT_USERNAME
      MONGO_INITDB_ROOT_PASSWORD: $MONGO_INITDB_ROOT_PASSWORD
    volumes:
      - baconstation-data:/data/db
```



Create volume to store data
```yml
volumes:
  baconstation-data:
    driver: local
```
Use .env file, and input environment variables. Be sure to add .env to gitignore before commit. Also, don't use admin:admin credentials.

```sh
MONGO_INITDB_ROOT_USERNAME=admin
MONGO_INITDB_ROOT_PASSWORD=admin
```
insert some test data with a playground file;

```js
/* global use, db */
// MongoDB Playground

const database = 'baconstation';
const collectionName  = 'movies';

// Create a new database.
use(database);

// Create a new collection.
const collection = db.getCollection(collectionName);

//const filePath = '/home/mumble/Documents/Projects/BaconStation/data/movies.json';
//const movies = JSON.parse(fs.readFileSync(filePath, 'utf-8'));
const movies = [
    {"_id":"573a1390f29313caabcd4135","plot":"Three men hammer on an anvil and pass a bottle of beer around.","genres":["Short"],"runtime":{"$numberInt":"1"},"cast":["Charles Kayser","John Ott"],"num_mflix_comments":{"$numberInt":"1"},"title":"Blacksmith Scene","fullplot":"A stationary camera looks at a large anvil with a blacksmith behind it and one on either side. The smith in the middle draws a heated metal rod from the fire, places it on the anvil, and all three begin a rhythmic hammering. After several blows, the metal goes back in the fire. One smith pulls out a bottle of beer, and they each take a swig. Then, out comes the glowing metal and the hammering resumes.","countries":["USA"],"released":{"$date":{"$numberLong":"-2418768000000"}},"directors":["William K.L. Dickson"],"rated":"UNRATED","awards":{"wins":{"$numberInt":"1"},"nominations":{"$numberInt":"0"},"text":"1 win."},"lastupdated":"2015-08-26 00:03:50.133000000","year":{"$numberInt":"1893"},"imdb":{"rating":{"$numberDouble":"6.2"},"votes":{"$numberInt":"1189"},"id":{"$numberInt":"5"}},"type":"movie","tomatoes":{"viewer":{"rating":{"$numberInt":"3"},"numReviews":{"$numberInt":"184"},"meter":{"$numberInt":"32"}},"lastUpdated":{"$date":{"$numberLong":"1435516449000"}}}},
    {"_id":"573a1390f29313caabcd42e8","plot":"A group of bandits stage a brazen train hold-up, only to find a determined posse hot on their heels.","genres":["Short","Western"],"runtime":{"$numberInt":"11"},"cast":["A.C. Abadie","Gilbert M. 'Broncho Billy' Anderson","George Barnes","Justus D. Barnes"],"poster":"https://m.media-amazon.com/images/M/MV5BMTU3NjE5NzYtYTYyNS00MDVmLWIwYjgtMmYwYWIxZDYyNzU2XkEyXkFqcGdeQXVyNzQzNzQxNzI@._V1_SY1000_SX677_AL_.jpg","title":"The Great Train Robbery","fullplot":"Among the earliest existing films in American cinema - notable as the first film that presented a narrative story to tell - it depicts a group of cowboy outlaws who hold up a train and rob the passengers. They are then pursued by a Sheriff's posse. Several scenes have color included - all hand tinted.","languages":["English"],"released":{"$date":{"$numberLong":"-2085523200000"}},"directors":["Edwin S. Porter"],"rated":"TV-G","awards":{"wins":{"$numberInt":"1"},"nominations":{"$numberInt":"0"},"text":"1 win."},"lastupdated":"2015-08-13 00:27:59.177000000","year":{"$numberInt":"1903"},"imdb":{"rating":{"$numberDouble":"7.4"},"votes":{"$numberInt":"9847"},"id":{"$numberInt":"439"}},"countries":["USA"],"type":"movie","tomatoes":{"viewer":{"rating":{"$numberDouble":"3.7"},"numReviews":{"$numberInt":"2559"},"meter":{"$numberInt":"75"}},"fresh":{"$numberInt":"6"},"critic":{"rating":{"$numberDouble":"7.6"},"numReviews":{"$numberInt":"6"},"meter":{"$numberInt":"100"}},"rotten":{"$numberInt":"0"},"lastUpdated":{"$date":{"$numberLong":"1439061370000"}}}},
    {"_id":"573a1390f29313caabcd4323","plot":"A young boy, opressed by his mother, goes on an outing in the country with a social welfare group where he dares to dream of a land where the cares of his ordinary life fade.","genres":["Short","Drama","Fantasy"],"runtime":{"$numberInt":"14"},"rated":"UNRATED","cast":["Martin Fuller","Mrs. William Bechtel","Walter Edwin","Ethel Jewett"],"num_mflix_comments":{"$numberInt":"2"},"poster":"https://m.media-amazon.com/images/M/MV5BMTMzMDcxMjgyNl5BMl5BanBnXkFtZTcwOTgxNjg4Mg@@._V1_SY1000_SX677_AL_.jpg","title":"The Land Beyond the Sunset","fullplot":"Thanks to the Fresh Air Fund, a slum child escapes his drunken mother for a day's outing in the country. Upon arriving, he and the other children are told a story about a mythical land of no pain. Rather then return to the slum at day's end, the lad seeks to journey to that beautiful land beyond the sunset.","languages":["English"],"released":{"$date":{"$numberLong":"-1804377600000"}},"directors":["Harold M. Shaw"],"writers":["Dorothy G. Shore"],"awards":{"wins":{"$numberInt":"1"},"nominations":{"$numberInt":"0"},"text":"1 win."},"lastupdated":"2015-08-29 00:27:45.437000000","year":{"$numberInt":"1912"},"imdb":{"rating":{"$numberDouble":"7.1"},"votes":{"$numberInt":"448"},"id":{"$numberInt":"488"}},"countries":["USA"],"type":"movie","tomatoes":{"viewer":{"rating":{"$numberDouble":"3.7"},"numReviews":{"$numberInt":"53"},"meter":{"$numberInt":"67"}},"lastUpdated":{"$date":{"$numberLong":"1430161595000"}}}},
    {"_id":"573a1390f29313caabcd446f","plot":"A greedy tycoon decides, on a whim, to corner the world market in wheat. This doubles the price of bread, forcing the grain's producers into charity lines and further into poverty. The film...","genres":["Short","Drama"],"runtime":{"$numberInt":"14"},"cast":["Frank Powell","Grace Henderson","James Kirkwood","Linda Arvidson"],"num_mflix_comments":{"$numberInt":"1"},"title":"A Corner in Wheat","fullplot":"A greedy tycoon decides, on a whim, to corner the world market in wheat. This doubles the price of bread, forcing the grain's producers into charity lines and further into poverty. The film continues to contrast the ironic differences between the lives of those who work to grow the wheat and the life of the man who dabbles in its sale for profit.","languages":["English"],"released":{"$date":{"$numberLong":"-1895097600000"}},"directors":["D.W. Griffith"],"rated":"G","awards":{"wins":{"$numberInt":"1"},"nominations":{"$numberInt":"0"},"text":"1 win."},"lastupdated":"2015-08-13 00:46:30.660000000","year":{"$numberInt":"1909"},"imdb":{"rating":{"$numberDouble":"6.6"},"votes":{"$numberInt":"1375"},"id":{"$numberInt":"832"}},"countries":["USA"],"type":"movie","tomatoes":{"viewer":{"rating":{"$numberDouble":"3.6"},"numReviews":{"$numberInt":"109"},"meter":{"$numberInt":"73"}},"lastUpdated":{"$date":{"$numberLong":"1431369413000"}}}},
];

collection.insertMany(movies);
collection.find();
```
# [TODO] build database



build grafana container
connect grafana with mongo
build dashboard
