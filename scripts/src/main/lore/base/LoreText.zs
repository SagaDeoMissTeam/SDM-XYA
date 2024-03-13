import stdlib.List;
import crafttweaker.api.text.Component;
import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.StringData;


public class LoreText{
    public var id as string;
    public var parent as ILore? = null;
    public var text as List<Component> = new List<Component>();

    public this(){

    }

    public this(id as string){
        this.id = id;
    }
    public this(id as string, text as List<Component>){
        this.id = id;
        this.text = text;
    }
    public this(id as string, text as Component[]){
        this.id = id;
        this.text = text as List<Component>;
    }

    public implements ILore{
        public getId(): string{
            return this.id;
        }

        public run(player: Player): void{
            player.sendMessage("Hello");
        }

        public setParent(parent: ILore): void{
            this.parent = parent;
        }

        public getParent(): ILore?{
            return this.parent;
        }

        public serialize(): MapData{
            var data as MapData = new MapData();
            data["type"] = getType().name;
            data["id"] = this.id;

            if(this.parent != null) data["parent"] = this.parent.getId();
            else data["parent"] = "null";

            var textList as ListData = new ListData();
            if(!text.isEmpty){
                for d1 in text{
                    textList.add(new StringData(d1.getString()));
                }
            }
            data["texts"] = textList;
            return data;
        }

        public deserialize(nbt: MapData): void{
            if("id" in nbt){
                this.id = nbt["id"] as string;
            }

            if("parent" in nbt){
                if(nbt["parent"] as string != "null"){
                    this.parent = LoreRegistry.LORE_KEY_MAP[nbt["parent"] as string];
                } else this.parent = LoreRegistry.NULL;
            }

            if("texts" in nbt){
                var textList as ListData = nbt["texts"] as ListData;
                for d1 in textList{
                    text.add(Component.literal(d1 as string));
                }
            }
        }

        public getType(): LoreType{
            return LoreType.TEXT;
        }
    }
}
