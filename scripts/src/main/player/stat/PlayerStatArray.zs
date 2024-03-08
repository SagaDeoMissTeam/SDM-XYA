
import stdlib.List;


        /*----------------------------------------------------------------
                        Класс характеристик в виде массива
        ------------------------------------------------------------------*/
public class PlayerStatArray<T> : PlayerStatBase{
    public var list as List<T> = new List<T>();

    public this(id as string, obj as T[]){
        super(id);
        this.list = obj as List<T>;
    }

}