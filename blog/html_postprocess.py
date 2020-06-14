import os, sys, subprocess
from bs4 import BeautifulSoup

infile = sys.argv[1]
print(f'post-processing {infile}')
os.chdir(os.path.dirname(infile))
infile = os.path.basename(infile)

# read and parse the input file
with open(infile) as inf:
    txt = inf.read()
    soup = BeautifulSoup(txt, 'html.parser')

os.makedirs('thumbs', exist_ok=True)
working_dir_images = set(x for x in os.listdir('.') if os.path.splitext(x)[1] in {'.jpg', '.png'})

for img in soup.find_all('img'):

    # make sure the image actually exists
    src = img.attrs['src']
    if not src in working_dir_images or not os.path.exists(src):
        print(f'skipping {src} because not in local directory')
        continue

    thumb = os.path.join('thumbs', os.path.splitext(src)[0]) + '.jpg'
    if not os.path.exists(thumb):
        print(f'generating thumbnail {thumb}')
        subprocess.check_call(
            ['mogrify', '-format', 'jpg', '-path', 'thumbs/', '-thumbnail', '800x800', src],
            shell=False,
        )

    # replace the original source with the thumbnail
    img.attrs['src'] = thumb
    # wrap the image in a link to the full-size image
    img_link = soup.new_tag("a", href=src, target="_blank")
    img.wrap(img_link)
    print(src)


# save the file again
with open(infile, "w") as outf:
    outf.write(soup.prettify(formatter='html'))

print(f'done {os.path.abspath(infile)}')
