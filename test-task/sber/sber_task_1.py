import pandas as pd
PATH=''
FILE_NAME_INPUT='Task1_INPUT.xlsx'
FILE_NAME_OUTPUT='Task1_OUTPUT123.xlsx'
def make_output_file(filename_in:str=FILE_NAME_INPUT,filename_out:str=FILE_NAME_OUTPUT,path:str=PATH)->None:
    """Создает файл excel, в котором указаны результирующие данные
     по количеству вызовов на каждом узле."""
    df_i = pd.read_excel(path+filename_in)
    df_i['КОЛИЧЕСТВО ВЫЗОВОВ'] = 0
    agg_df = df_i.groupby(['Имя активности']).agg({'КОЛИЧЕСТВО ВЫЗОВОВ': 'count'})
    agg_df = agg_df.astype(int)
    agg_df['ПРОЦЕНТ'] = agg_df['КОЛИЧЕСТВО ВЫЗОВОВ'].apply(lambda x: 100 * (x / agg_df['КОЛИЧЕСТВО ВЫЗОВОВ'].max()))
    agg_df.loc['Кнопка 3 - Потеряно в Меню'] = agg_df.loc['Кнопка 3 - Прослушал Главное Меню'] \
                                               - agg_df.loc['Кнопка 3 - Распределился на оператора Группы Ипотеки'] \
                                               - agg_df.loc['Кнопка 3 - Распределился на оператора Группы Кредитов']
    agg_df.loc['Cреднее время обработки вызова (секунды)'] = (
        df_i['Длительность'].sum() / len(df_i['ID вызова'].unique()), None
    )
    agg_df['КОЛИЧЕСТВО ВЫЗОВОВ'] = agg_df['КОЛИЧЕСТВО ВЫЗОВОВ'].astype(int)
    agg_df['ПРОЦЕНТ'] = agg_df['ПРОЦЕНТ'].apply(lambda x: str(round(x, 2)) + '%')
    agg_df.index=agg_df.index.rename('МЕТРИКА')

    with pd.ExcelWriter(filename_out) as wb:
        agg_df.to_excel(wb, sheet_name='Results')
        worksheet = wb.sheets['Results']

        for i,c in enumerate(agg_df):
            worksheet.set_column(i, i, 50)  # задаем ширину колонок
if __name__ == '__main__':
    make_output_file()