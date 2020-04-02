
//SDK Doc: https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/athena/model/QueryExecutionContext.html#setDatabase-java.lang.String-
import com.amazonaws.services.athena.model.StartQueryExecutionRequest;
import com.amazonaws.services.athena.model.StartQueryExecutionResult;
import com.amazonaws.services.athena.model.ResultConfiguration;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.athena.AmazonAthena;
import com.amazonaws.services.athena.AmazonAthenaClientBuilder;

public class Main {


    public static void main(String[] args) {

        AmazonAthenaClientBuilder builder = AmazonAthenaClientBuilder.standard()
                .withRegion(Regions.EU_WEST_1);

        AmazonAthena client = builder.build();

        ResultConfiguration resultConfiguration = new ResultConfiguration()
                .withOutputLocation("s3://xxx/");


        StartQueryExecutionRequest startQueryExecutionRequest = new StartQueryExecutionRequest()
                .withQueryString("show databases")
                .withResultConfiguration(resultConfiguration);


        StartQueryExecutionResult startQueryExecutionResult = client.startQueryExecution(startQueryExecutionRequest);
        String queryExecutionId =  startQueryExecutionResult.getQueryExecutionId();
        System.out.println(queryExecutionId);

    }
}
