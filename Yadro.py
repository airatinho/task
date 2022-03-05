class DeleteError(Exception):
    pass

class File:
    def __init__(self,name:str):
        self.name = name

    def delete(self):
        print(f'Удаляю имя файла {self.name}!')

    def protect(self):
        raise NotImplementedError

class Artifact(File):
    __protected=False

    def delete(self):
        if self.__protected:
            raise DeleteError(f'Файл {self.name} защищен от удаления!')
        print(f'Удаляю имя файла {self.name}!')

    def protect(self):
        print(f'Файл {self.name} защищен от удаления!')
        if not self.__protected:
            self.__protected = True



