"use client"
import React, { useState } from "react";

const PaperStatus = () => {
  const [paperId, setPaperId] = useState("");
  const [paper, setPaper] = useState(null);
  const [error, setError] = useState("");

  const handleFetchStatus = async () => {
    try {
      const response = await fetch(`http://localhost:3001/paper/${paperId}`);
      if (response.ok) {
        const data = await response.json();
        setPaper(data);
        setError("");
      } else {
        const result = await response.json();
        setError(result.error || "Error fetching paper status.");
      }
    } catch (error) {
      setError("Error: " + error.message);
    }
  };

  return (
    <div className="max-w-md mx-auto mt-10 p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-semibold text-gray-800 mb-4">Paper Status</h2>
      <div className="space-y-4">
        <div>
          <label htmlFor="paperId" className="block text-gray-700 font-medium">
            Paper ID
          </label>
          <input
            type="text"
            id="paperId"
            value={paperId}
            onChange={(e) => setPaperId(e.target.value)}
            className="w-full mt-2 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
            placeholder="Enter Paper ID"
          />
        </div>
        <button
          onClick={handleFetchStatus}
          className="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600"
        >
          Fetch Status
        </button>
      </div>
      {paper && (
        <div className="mt-4 p-4 bg-gray-100 rounded-md">
          <h3 className="text-lg font-semibold text-gray-800">
            Paper Details:
          </h3>
          <p>
            <strong>Title:</strong> {paper.Title}
          </p>
          <p>
            <strong>Status:</strong> {paper.Status}
          </p>
        </div>
      )}
      {error && (
        <p className="mt-4 text-center text-red-600 font-medium">{error}</p>
      )}
    </div>
  );
};

export default PaperStatus;
