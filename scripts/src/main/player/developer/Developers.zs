import crafttweaker.api.text.Component;
import stdlib.List;
import crafttweaker.api.entity.type.player.Player;
import mods.sdmengine.snbt.SDMCompoundTag;
import mods.sdmengine.snbt.SNBTCompoundTag;
import crafttweaker.api.data.MapData;
import mods.sdmengine.snbt.SNBT;
import crafttweaker.api.data.ListData;

public class Developers{
    public static var developers as List<Developer> = new List<Developer>();

    public static register(name: string) as string{
        developers.add(new Developer(name, 3));
        return name;
    }

    public static init() as void{
        register("Sixik");
        register("kitoragas");
        register("vanilovv");
    }

    public static isDeveloper(player: Player) as bool{
        for dev in developers{
            if(dev.nick == player.name.getString()) return true;
        }
        return false;
    }

    public static getLevel(player: Player) as int{
        for dev in developers{
            if(dev.nick == player.name.getString()) return dev.devLevel;
        }

        return 0;
    }

    public static updateData(player: Player) as void{
        if(isDeveloper(player)){
            if(!("developer" in player.customData)) player.updateCustomData({"developer" : true});
        }
    }

    public static serialize() as void {
        var data as MapData = new MapData();
        var list as ListData = new ListData();
        for dev in developers{
            list.add(dev.serialize());
        }
        data["developers"] = list;


        var dataFile as SNBTCompoundTag = SDMCompoundTag.of(data) as SNBTCompoundTag;
        SNBT.write(SDMFile.developersFile, dataFile);
    }

    public static deserialize() as void{
        var snbtData as SNBTCompoundTag? = SNBT.read(SDMFile.developersFile) as SNBTCompoundTag?;
        if(snbtData != null){
            developers = new List<Developer>();
            var data as MapData = snbtData.getMapData();
            if("developers" in data){
                var list as ListData = data["developers"] as ListData;
                for d1 in list{
                    var developer as Developer = new Developer();
                    developer.deserialize(d1 as MapData);
                    developers.add(developer);
                }
            }
        }
    }
}


public class Developer{
    public var nick as string;
    public var devLevel as int;
    public this(){
        nick = "NULL";
        devLevel = -1;
    }
    public this(nick as string, devLevel as int){
        this.nick = nick;
        this.devLevel = devLevel;
    }

    public serialize() as MapData{
        var data as MapData = new MapData();

        data["nick"] = nick;
        data["level"] = devLevel;
        return data;
    }

    public deserialize(data as MapData) as void{
        if("nick" in data) nick = data["nick"] as string;
        if("level" in data) devLevel = data["level"] as int;
    }
}