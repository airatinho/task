from Yadro import Artifact,DeleteError
import pytest

def test_create_artifact():
    _ = Artifact('my_file')

def test_delete_art():
    art = Artifact('my_file')
    art.delete()

def test_protect_art():
    art = Artifact('my_file')
    art.protect()
    with pytest.raises(DeleteError):
        art.delete()
