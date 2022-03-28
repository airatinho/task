import tensorflow_datasets as tfds
celeb_bldr=tfds.builder('celeb_a_hq')

celeb_bldr.download_and_prepare()