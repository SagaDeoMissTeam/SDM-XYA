
import stdlib.List;

public class Dimensions{
    public static val dimensionsList as List<string> = new List<string>();

    public static init() as void{
        register("minecraft:overworld");
        register("minecraft:the_end");
        register("minecraft:the_nether");
    }

    public static register(dim as string) as string{
        dimensionsList.add(dim);
        return dim;
    }
}