import stdlib.List;
import crafttweaker.api.text.Component;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.StringData;
import crafttweaker.api.entity.type.player.Player;

public class TimerBase{
    public var player as Player;
    public var id as string = "null";
    public var currentTime as int = 0;
    public var endTime as int = 0;
    public var isEnd as bool = false;
    public var lore as ILore;

    public this(player as Player){
        this.player = player;
    }

    public this(id as string, endTime as int, player as Player, lore as ILore){
        this.id = id;
        this.endTime = endTime;
        this.lore = lore;
        this.player = player;
    }

    public addTime() as void{
        this.currentTime += 1;
    }

    public setStop() as void{
        this.isEnd = true;
    }

    public serialize(): MapData {
        var data as MapData = new MapData();
        data["id"] = this.id;
        data["currentTime"] = this.currentTime;
        data["endTime"] = this.endTime;
        data["lore"] = this.lore.serialize();
        data["isEnd"] = this.isEnd as bool;
        return data;
    }

    public deserialize(nbt: MapData): void{
        this.id = nbt["id"] as string;
        this.currentTime = nbt["currentTime"] as int;
        this.endTime = nbt["endTime"] as int;
        var ld as LoreText = new LoreText();
        ld.deserialize(nbt["lore"]);
        this.isEnd = nbt["isEnd"] as bool;
        this.lore = ld;
    }

    public onTick() as void{
        if(!this.isEnd){
            if(currentTime >= endTime){
                lore.run(player);
                setStop();
            }
            addTime();
        }
    }
}