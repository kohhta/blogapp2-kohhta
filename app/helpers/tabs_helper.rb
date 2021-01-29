module TabsHelper

  # tabsの動的クラス付与メソッド
  def add_active_class(path)
    'active'  if curremt_page?(path)
  end
  
end