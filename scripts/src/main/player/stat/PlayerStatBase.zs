import crafttweaker.api.data.MapData;
import stdlib.List;


        /*----------------------------------------------------------------
                        Базовый класс характеристик
        ------------------------------------------------------------------*/
public abstract virtual class PlayerStatBase {
    public var id as string;

    public this(){

    }
    public this(id as string){
        this.id = id;
    }

    public abstract serialize() as MapData{
        var data as MapData = new MapData();
        data["id"] = id;
        return data;
    }

    public abstract deserialize(data as MapData) as void{
        this.id = data["id"].toString();
    }

}