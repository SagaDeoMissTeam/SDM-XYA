import crafttweaker.api.data.MapData;


        /*----------------------------------------------------------------
                        Класс характеристик в виде значения
        ------------------------------------------------------------------*/
public class PlayerStatValue : PlayerStatBase {

    public var value as double;

    public this(){
        super("");
    }
    public this(id as string, value as double){
        super(id);
        this.value = value;
    }


    public serialize() as MapData{
        var data as MapData = new MapData();
        data["id"] = id;
        data["value"] = value;
        return data;
    }

    public deserialize(data as MapData) as void{
        this.id = data["id"].toString();
        this.value = data["value"].asDouble();
    }
}