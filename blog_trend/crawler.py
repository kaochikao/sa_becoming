
import requests
from bs4 import BeautifulSoup
import time
import csv

def download_page(url, file):

    res = requests.get(url=url)
    f = open(file, 'w+')
    print(res.content)
    f.write(str(res.content))
    f.close()



def extract(file):
    f = open(file, 'r')
    html = f.read()
    soup = BeautifulSoup(html, 'html.parser')

    posts = soup.find_all("article", class_="blog-post")
    post_info = []

    for post in posts:
        time = post.find("time").attrs.get('datetime')
        header = post.find("h2", class_="blog-post-title")
        anchor = header.find('a')
        title = anchor.find('span').text
        link = anchor.attrs.get('href')

        authors = post.find_all('span', property='name')
        authors = [author.text for author in authors]

        post_info.append({
            'title': title,
            'time': time,
            'authors': authors,
            'link': link
        })

    return post_info


def download_index_pages():
    BIGDATA_BLOG = 'https://aws.amazon.com/blogs/big-data'
    index_links = ["{}/page/{}/".format(BIGDATA_BLOG, i) for i in range(2, 47)]
    index_links = [BIGDATA_BLOG] + index_links


    for i in range(len(index_links)):

        url = index_links[i]
        file = 'data/indices/index_{}.html'.format(i)

        download_page(url, file)
        time.sleep(2)


def create_index():

    with open('data/indices/index_agg.csv', 'w+') as f:
        headers = ['title', 'time', 'authors', 'link']
        writer = csv.DictWriter(f, headers)
        writer.writeheader()

        for i in range(46):
            posts = extract('data/indices/index_{}.html'.format(i))
            writer.writerows(posts)