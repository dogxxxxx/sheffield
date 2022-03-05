```

class Retrieve:
    # Create new Retrieve object storing index and term weighting 
    # scheme. (You can extend this method, as required.)
    def __init__(self, index, term_weighting):
        self.index = index
        self.term_weighting = term_weighting
        self.num_docs = self.compute_number_of_documents()
        self.get_doc()
        if term_weighting == 'tfidf':
            self.get_tfidf_doc()

    def compute_number_of_documents(self):
        self.doc_ids = set()
        for term in self.index:
            self.doc_ids.update(self.index[term])
        return len(self.doc_ids)

    # Method performing retrieval for a single query (which is 
    # represented as a list of preprocessed terms). Returns list 
    # of doc ids for relevant docs (in rank order).
    def for_query(self, query):
        ans = []
        if self.term_weighting == 'binary':
            ans = self.jaccard(self.result_dict, query)
            return ans
        elif self.term_weighting == 'tf':
            ans = self.computeTF(self.result_dict, query)
            return ans
        elif self.term_weighting == 'tfidf':
            ans = self.tfidf_result(self.result_dict, query)
            return ans

    def get_tfidf_doc(self):
        import math
        d = len(self.result_dict)
        self.tfidf_doc = {}
        for doc, item in self.result_dict.items():
            self.tfidf_doc[doc] = {}
            for word, times in item.items():
                df = 0
                for v in self.result_dict.values():
                    if word in v:
                        df += 1
                self.tfidf_doc[doc][word] = (math.log(d/df, 10))*times
    
    def tfidf_result(self, result_dict, query):
        import math
        idf_query = {}
        tf_query = {}
        d = len(result_dict)
        for word in query:
            df = 0
            for item in result_dict.values():
                if word in item:
                    df += 1
            if df == 0:
                idf_query[word] = 0
            else:
                idf_query[word] = math.log(d/df, 10)
            
            if word not in tf_query.keys():
                tf_query[word] = 1
            else:
                tf_query[word] += 1

        tfidf_query = { k: idf_query[k] * tf_query[k] for k in tf_query}
        sigma_query = 0
        for i in tfidf_query.values():
            sigma_query = sigma_query + i*i  
        sigma_doc = {}
        for doc, j in self.tfidf_doc.items():
            sigma_doc[doc] = 0
            for tfidf in j.values():
                sigma_doc[doc] = sigma_doc[doc] + tfidf*tfidf
        result = {}
        for docs, values in self.tfidf_doc.items():
            a = 0
            for words, tfidf_docs in values.items():
                if words in tfidf_query.keys():
                    a = tfidf_docs * tfidf_query[words] + a
            result[docs] = a/(math.sqrt(sigma_doc[docs])*math.sqrt(sigma_query))
        import sys
        top_N = 10
        pairs = sorted(result, key=lambda v:result[v], reverse=True)
        if top_N > 0:
            pairs = pairs[:top_N]
        return pairs[:top_N]
    

    def computeTF(self, result_dict, query):
        import math
        query_count = {}
        for word in query:
            if word not in query_count:
                query_count[word] = 1
            else:
                query_count[word] += 1
        result = {}
        for doc, item in result_dict.items():
            final_values = 0
            for word, times in item.items():
                if word in query_count:
                    final_values = times*query_count[word] + final_values
                    
            result[doc] = final_values
        sigma_query = 0
        for frequency in query_count.values():
            sigma_query = sigma_query + frequency*frequency
        
        sigma_doc = {}
        for docs, value in result_dict.items():
            sigma = 0
            for times in value.values():
                sigma = sigma + times*times
            sigma_doc[docs] = sigma  

        final_result = { doc: result[doc] / (math.sqrt(sigma_doc[doc]) * math.sqrt(sigma_query)) for doc in result}
        import sys
        top_N = 10
        pairs = sorted(final_result, key=lambda v:final_result[v], reverse=True)
        if top_N > 0:
            pairs = pairs[:top_N]
        return pairs[:top_N]

    def jaccard(self, result_dict, query):
        pre_doc = []
        doc_name = []
        for a, b in result_dict.items():
            pre_doc.append(b)
            doc_name.append(a) 
        doc = []      
        for i in range(len(pre_doc)):
            doc.append(pre_doc[i].keys())
        sim = {}     

        for j in range(len(doc)):
            wds1 = set(query)
            wds2 = set(doc[j])
            over  = len(wds1 & wds2)
            under = len(wds1 | wds2)
            if under > 0:
                sim[doc_name[j]] =  over / under
            else:
                sim[doc_name[j]] = 0.0
        import sys
        top_N = 10
        pairs = sorted(sim, key=lambda v:sim[v], reverse=True)
        if top_N > 0:
            pairs = pairs[:top_N]
        return pairs[:top_N]
    
    def get_doc(self):
        doc_arr = []
        times_arr = []
        word_arr = []
        i = 0
        for a, b in self.index.items():
            for c,d in self.index[a].items():
                doc_arr.append(c)
                times_arr.append(d)
                word_arr.append(a)
                i += 1

        full_matrix = [[doc_arr[i], word_arr[i], times_arr[i]]  for i in range(len(doc_arr))]
        self.result_dict = {}
        for i in range(len(doc_arr)):
            if full_matrix[i][0] not in self.result_dict:
                self.result_dict[full_matrix[i][0]] = {}
                self.result_dict[full_matrix[i][0]][full_matrix[i][1]] = full_matrix[i][2]
            else:
                self.result_dict[full_matrix[i][0]][full_matrix[i][1]] = full_matrix[i][2]
```                
