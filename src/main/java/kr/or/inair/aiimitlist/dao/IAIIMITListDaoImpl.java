package kr.or.inair.aiimitlist.dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IAIIMITListDaoImpl implements IAIIMITListDao {
	@Autowired
	private SqlMapClient client;

}
